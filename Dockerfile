FROM public.ecr.aws/lambda/nodejs:16

COPY index.js package.json  ${LAMBDA_TASK_ROOT}

RUN npm install

CMD [ "index.handler" ]
