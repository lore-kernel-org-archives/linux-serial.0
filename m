From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v4 0/4] ACPI: parse the SPCR table
Date: Thu, 3 Mar 2016 07:35:40 -0800
Message-ID: <56D859CC.7010901@hurleysoftware.com>
References: <1456747355-15692-1-git-send-email-aleksey.makarov@linaro.org>
 <56D5B5CB.7010702@hurleysoftware.com> <56D8272E.20705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <56D8272E.20705@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Aleksey Makarov <amakarov.linux@gmail.com>, Aleksey Makarov <aleksey.makarov@linaro.org>, linux-acpi@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Yury Norov <ynorov@caviumnetworks.com>, "Zheng, Lv" <lv.zheng@intel.com>
List-Id: linux-serial@vger.kernel.org

On 03/03/2016 03:59 AM, Aleksey Makarov wrote:
> 
> 
> On 03/01/2016 06:31 PM, Peter Hurley wrote:
>> On 02/29/2016 04:02 AM, Aleksey Makarov wrote:
>>> 'ARM Server Base Boot Requirements' [1] mentions SPCR (Serial Port
>>> Console Redirection Table) [2] as a mandatory ACPI table that
>>> specifies the configuration of serial console.
>>>
>>> Introduce a new function acpi_console_check().  At the uart port
>>> registration, this function checks if the ACPI SPCR table specifies
>>> its argument of type struct uart_port to be a console
>>> and if so calls add_preferred_console().
>>
>> How will a user enable an earlycon on the same console as the SPCR
>> console if there is no DBG2 table?
> 
> ...
> [    0.000000] earlycon: pl11 at MMIO 0x0000000009000000 (options '')
> [    0.000000] bootconsole [pl11] enabled
> ...
> [    0.000000] Kernel command line:  root=/dev/vda1 rw systemd.show_status=no acpi=force earlycon=pl011,0x9000000
> ...
> [    0.318248] ACPI: SPCR: adding preferred console [ttyAMA0]
> [    0.318736] ARMH0011:00: ttyAMA0 at MMIO 0x9000000 (irq = 5, base_baud = 0) is a SBSA
> [    0.319502] console [ttyAMA0] enabled
> [    0.319502] console [ttyAMA0] enabled
> [    0.319933] bootconsole [pl11] disabled
> [    0.319933] bootconsole [pl11] disabled
> ...
> 
> Why?

That's pretty disingenuous; via command line?

By that measure, none of your patches are required because a user
can already start both console and earlycon without them.

With the console location specified in the SPCR, earlycon should
be opt-in on the command-line simply with "earlycon" command-line
parameter.
