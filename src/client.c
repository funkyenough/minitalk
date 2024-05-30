#include "minitalk.h"

void	send_char(pid_t pid, char c)
{
	int	digit;

	digit = 7;
	while (digit >= 0)
	{
		if (c & (1 << digit))
		{
			printf("SIGUSR1: %d\n", kill(pid, SIGUSR1));
			// printf("1");
		}
		else
		{
			printf("SIGUSR2: %d\n", kill(pid, SIGUSR2));
			// printf("0");
		}
		digit--;
		usleep(100);
	}
}

void	send_str(pid_t pid, char *str)
{
	while (*str)
	{
		send_char(pid, *str);
		printf("\n");
		str++;
	}
}

int	main(int argc, char **argv)
{
	int pid;

	if (argc != 3)
		return (1);

	printf("pid = %d\n", pid = ft_atoi(argv[1]));
	send_str(pid, argv[2]);

	return (0);
}