CLIENT = client
SERVER = server
LIBFT = libft.a
FT_PRINTF = libftprintf.a

SRCDIR = ./src
OBJDIR = ./obj
LIBFTDIR = ./libft
FT_PRINTFDIR = ./ft_printf
SRCS = $(wildcard $(SRCDIR)/*.c)
OBJS = $(patsubst $(SRCDIR)/%.c,$(OBJDIR)/%.o,$(SRCS))

AR = ar
ARFLAGS = rcs

CC = cc
CFLAGS = -Wall -Werror -Wextra
CSAFE = -g -fsanitize=address

RM = rm -f

ifdef WITH_SAFE
    CC += $(CSAFE)
endif

all : $(CLIENT) $(SERVER)

dev : clone_libs $(NAME)

clone_libs:
	if [ ! -d "$(LIBFTDIR)" ]; then git clone https://github.com/funkyenough/42_libft.git $(LIBFTDIR); fi
	if [ ! -d "$(FT_PRINTFDIR)" ]; then git clone https://github.com/funkyenough/ft_printf.git $(FT_PRINTFDIR); fi

$(SERVER) : $(OBJDIR) $(OBJS) $(LIBFTDIR)/$(LIBFT) $(FT_PRINTFDIR)/$(FT_PRINTF)
	@echo "Compilation of minitalk begins"
	$(CC) $(CFLAGS) -o $(NAME) $(OBJS) $(OBJDIR)/$(LIBFT) $(OBJDIR)/$(FT_PRINTF)

$(CLIENT) : $(OBJDIR) $(OBJS) $(LIBFTDIR)/$(LIBFT) $(FT_PRINTFDIR)/$(FT_PRINTF)
	@echo "Compilation of minitalk begins"
	$(CC) $(CFLAGS) -o $(NAME) $(OBJS) $(OBJDIR)/$(LIBFT) $(OBJDIR)/$(FT_PRINTF)

$(LIBFTDIR)/$(LIBFT) :
	make bonus -C $(LIBFTDIR)
	cp $(LIBFTDIR)/$(LIBFT) $(OBJDIR)

$(FT_PRINTFDIR)/$(FT_PRINTF) :
	make -C $(FT_PRINTFDIR)
	cp $(FT_PRINTFDIR)/$(FT_PRINTF) $(OBJDIR)

$(OBJDIR)/%.o : $(SRCDIR)/%.c | $(OBJDIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(OBJDIR) :
	mkdir -p $(OBJDIR)

safe :
	make WITH_SAFE=1 all

clean:
	$(RM) -rf $(OBJDIR)

fclean: clean
	$(RM) $(NAME)


re: fclean all
