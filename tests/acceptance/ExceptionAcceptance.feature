Feature: Exception

  Background:
    Given I have the following config
      """
      <?xml version="1.0"?>
      <psalm>
        <projectFiles><directory name="."/></projectFiles>
        <stubs>
            <file name="../../stubs-for-exception/LoggerInterface.phpstub" />
        </stubs>
      </psalm>
      """
    And I have the following code preamble
      """
      <?php
      use Psr\Log\LoggerInterface;

      /**
       * @psalm-suppress InvalidReturnType
       * @return LoggerInterface
       */
      function impl_interface() {}
      """

  Scenario: `exception` key is actually an Exception Object AS per LoggerInterface
    Given I have the following code
      """
      impl_interface()->emergency("message", ['exception' => 'foo']);
      impl_interface()->alert("message", ['exception' => 'foo']);
      impl_interface()->critical("message", ['exception' => 'foo']);
      impl_interface()->error("message", ['exception' => 'foo']);
      impl_interface()->warning("message", ['exception' => 'foo']);
      impl_interface()->notice("message", ['exception' => 'foo']);
      impl_interface()->info("message", ['exception' => 'foo']);
      impl_interface()->debug("message", ['exception' => 'foo']);
      impl_interface()->emergency("message", ['exception' => new Error]);
      impl_interface()->alert("message", ['exception' => new Error]);
      impl_interface()->critical("message", ['exception' => new Error]);
      impl_interface()->error("message", ['exception' => new Error]);
      impl_interface()->warning("message", ['exception' => new Error]);
      impl_interface()->notice("message", ['exception' => new Error]);
      impl_interface()->info("message", ['exception' => new Error]);
      impl_interface()->debug("message", ['exception' => new Error]);
      """
    When I run Psalm
    Then I see these errors
      | Type            | Message                                                                                                                      |
      | InvalidArgument | Argument 2 of Psr\Log\LoggerInterface::emergency expects array{exception?: Exception}, but array{exception: 'foo'} provided |
      | InvalidArgument | Argument 2 of Psr\Log\LoggerInterface::alert expects array{exception?: Exception}, but array{exception: 'foo'} provided |
      | InvalidArgument | Argument 2 of Psr\Log\LoggerInterface::critical expects array{exception?: Exception}, but array{exception: 'foo'} provided |
      | InvalidArgument | Argument 2 of Psr\Log\LoggerInterface::error expects array{exception?: Exception}, but array{exception: 'foo'} provided |
      | InvalidArgument | Argument 2 of Psr\Log\LoggerInterface::warning expects array{exception?: Exception}, but array{exception: 'foo'} provided |
      | InvalidArgument | Argument 2 of Psr\Log\LoggerInterface::notice expects array{exception?: Exception}, but array{exception: 'foo'} provided |
      | InvalidArgument | Argument 2 of Psr\Log\LoggerInterface::info expects array{exception?: Exception}, but array{exception: 'foo'} provided |
      | InvalidArgument | Argument 2 of Psr\Log\LoggerInterface::debug expects array{exception?: Exception}, but array{exception: 'foo'} provided |
      | InvalidArgument | Argument 2 of Psr\Log\LoggerInterface::emergency expects array{exception?: Exception}, but array{exception: Error} provided |
      | InvalidArgument | Argument 2 of Psr\Log\LoggerInterface::alert expects array{exception?: Exception}, but array{exception: Error} provided |
      | InvalidArgument | Argument 2 of Psr\Log\LoggerInterface::critical expects array{exception?: Exception}, but array{exception: Error} provided |
      | InvalidArgument | Argument 2 of Psr\Log\LoggerInterface::error expects array{exception?: Exception}, but array{exception: Error} provided |
      | InvalidArgument | Argument 2 of Psr\Log\LoggerInterface::warning expects array{exception?: Exception}, but array{exception: Error} provided |
      | InvalidArgument | Argument 2 of Psr\Log\LoggerInterface::notice expects array{exception?: Exception}, but array{exception: Error} provided |
      | InvalidArgument | Argument 2 of Psr\Log\LoggerInterface::info expects array{exception?: Exception}, but array{exception: Error} provided |
      | InvalidArgument | Argument 2 of Psr\Log\LoggerInterface::debug expects array{exception?: Exception}, but array{exception: Error} provided |
    And I see no other errors

