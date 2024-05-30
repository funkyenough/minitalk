#include "minitalk.h"
#include <stdio.h>

volatile sig_atomic_t	g_char = 0;

void	signal_handler(int status)
{
	static int	i;
	char		c;

	g_char = g_char << 1;
	// receive signal from the client
	if (status == SIGUSR1)
		g_char += 1;
	if (status == SIGUSR2)
		;
	i++;
	c = 0xFF & g_char;
	if (i == 8)
	{
		write(1, &c, 1);
		i = 0;
	}
}

int	main(void)
{
	struct sigaction	sa;

	sa.sa_handler = signal_handler;
	sigemptyset(&sa.sa_mask);
	printf("PID is: %d\n", getpid());
	sigaction(SIGUSR1, &sa, NULL);
	sigaction(SIGUSR2, &sa, NULL);
	while (1)
		pause();
	return (0);
}
