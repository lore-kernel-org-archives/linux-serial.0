From: Jon Masters <jcm@redhat.com>
Subject: Re: [RFC v2 0/4] ACPI: SPCR: 32-bit access and non-standard baud rate
Date: Tue, 6 Dec 2016 13:20:49 -0500
Message-ID: <c3912e9e-0429-02db-4af1-15b624af9335@redhat.com>
References: <20161206175830.6989-1-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161206175830.6989-1-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Peter Hurley <peter@hurleysoftware.com>, Mark Salter <msalter@redhat.com>, Duc Dang <dhdang@apm.com>, Rob Herring <robh@kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Aleksey,

On 12/06/2016 12:58 PM, Aleksey Makarov wrote:

> It turns out that this approach does not work for all the existing hardware.
> There are two problems with AppliedMicro X-Gene based boards
> ([discussion], [v1]):
> 
> 1. Their console is a 16550 port that requires 32-bit access.  Now SPCR does not
>    have any method to specify this.
> 
> 2. Some of the boards don't use the "standard" 16550 clock rate so supplying
>    a baud rate makes it change to a random baud rate.
> 
> Patch 1/4 uses 'Register Bit Width' field of the ACPI Generic Address
> Structure that specifies the address of the UART registers to
> decide if the driver should use "mmio32" access instead of "mmio".
> This fixes problem 1 for existing hardware/firmware.
> 
> To fix problem 2, I suggest to introduce a new value '0' for the "Baud Rate"
> field of SPCR (now this value is reserved).  I would like to discuss if this
> could be added to SPCR spec and will fix the problem.

Part 1 could well be solved in this way, provided it can be made part
of the mainstream specification. It seems fairly reasonable, however.

I'm not sure I subscribe to part 2 because there could be all manner
of havoc changing the interpretation of existing zero values. That is
why I personally favor an AppliedMicro SPCR subtype specific to them.

That all said, I did discuss exactly part 2 with the folks responsible
for the SPCR specification and they are thinking about their preferred
solution, which will likely either be a new subtype for Applied, or
perhaps allow for what you describe. I will followup when I know.

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop
