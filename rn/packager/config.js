const config = {
  getTransformOptions: () => {
    return {
      transform: { inlineRequires: true },
    };
  },
};

module.exports = config;
