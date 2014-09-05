From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [RFC PATCH 1/1] drivers: introduce ARM SBSA generic UART driver
Date: Fri, 05 Sep 2014 11:24:52 -0400
Message-ID: <5409D5C4.5000905@hurleysoftware.com>
References: <1409328803-1953-1-git-send-email-andre.przywara@arm.com> <1409328803-1953-2-git-send-email-andre.przywara@arm.com> <54060A4B.2050504@hurleysoftware.com> <5409CC61.1040709@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:52591 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751289AbaIEPZD (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 5 Sep 2014 11:25:03 -0400
In-Reply-To: <5409CC61.1040709@arm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andre Przywara <andre.przywara@arm.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "linux@vger.kernel.org" <linux@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>

On 09/05/2014 10:44 AM, Andre Przywara wrote:
> On 02/09/14 19:19, Peter Hurley wrote:
>> On 08/29/2014 12:13 PM, Andre Przywara wrote:
>>> +static void
>>> +sbsa_uart_set_termios(struct uart_port *port, struct ktermios *termios,
>>> +               struct ktermios *old)
>>> +{
>>> +     unsigned long flags;
>>> +     unsigned int baud = 115200;
>>> +
>>> +     spin_lock_irqsave(&port->lock, flags);
>>         ^^^^^^^^^^^^^^^^^
>>
>> Can be spin_lock_irq(&port->lock) here.
> 
> Why is this? Because this code cannot be called with interrupts already
> off?

Yes.

> This would apply to the original PL011 driver also then?

Also, yes.

I mentioned it because new code should use the spin_lock_irq() flavor
[primarily as a visual aid for driver authors].

Regards,
Peter Hurley
