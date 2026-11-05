NAME = Inception

all: prepare $(NAME)

$(NAME):
	@docker compose -f ./srcs/docker-compose.yml --env-file "./srcs/.env" up

prepare:
	@bash ./srcs/requirements/tools/setup.sh

clean:
	@bash ./srcs/requirements/tools/clean.sh

fclean: clean
	@bash ./srcs/requirements/tools/fclean.sh

re: fclean all

.PHONY: prepare clean fclean re
