From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 2/2] tty: serial core: use the ACPI PM state defines
Date: Thu, 6 Dec 2012 19:31:31 +0000
Message-ID: <20121206193131.33823e02@bob.linux.org.uk>
References: <1354819612-2401-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1354819612-2401-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Rickard Andersson <rickard.andersson@stericsson.com>, linux-acpi@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-serial@vger.kernel.org

On Thu, 6 Dec 2012 19:46:52 +0100
Linus Walleij <linus.walleij@stericsson.com> wrote:

> From: Linus Walleij <linus.walleij@linaro.org>
> 
> The Documentation/serial/driver file defines that:
> 
>   State indicates the new state (defined by ACPI D0-D3),
>   oldstate indicates the previous state.  Essentially, D0
>   means fully on, D3 means powered down.
> 
> So let's change the code to actually using the defined ACPI
> states instead of using magic numbers.

The "magic numbers" being "1" to mean one, "2" to mean two etc..

Almost none of the platforms using the serial driver even have ACPI so
this seems to be an obfuscation of a simple numbering system for a
subsystem specific set of definitions that may or may not fit in future.

What are you going to do if it turns out serial ports on some platform
have a state that doesn't fit ACPI_STATE_foo because its got a
behaviour that isn't in the ACPI specification ?

This seems to be tying stuff together in a way that will just cause
future pain.

Alan
