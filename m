From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: tcflow(TCOON/TCOOFF) vs. received XON/XOFF characters
Date: Thu, 17 Jul 2014 09:09:47 -0400
Message-ID: <53C7CB1B.3010804@hurleysoftware.com>
References: <lq6c9q$isi$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:41963 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755186AbaGQNJt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 Jul 2014 09:09:49 -0400
In-Reply-To: <lq6c9q$isi$1@ger.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>, linux-serial@vger.kernel.org

On 07/16/2014 01:20 PM, Grant Edwards wrote:
> I'm working on the regression test appliction I use to test the serial
> drivers I maintain, and I've run into a problem with interaction
> between tcflow(TCOON/TCOOFF) and XON/XOFF using bog-standard 16x50
> UARTs and the normal in-kernel driver.
>
> When I call tcflow(TCOOFF) on a tty device and then write data to that
> tty device, the data isn't sent. That's what I expect. But, when an
> XON is then received by that port, it does not start the tx data.
>
> Conversly, when a serial port receives an XOFF, it stops sending
> data as it should, but a subsequent call to tcflow(TCOON) does not
> casue it to start sending data.
>
> Am I misunderstanding how tcflow(TCOxxx) is supposed to interact with
> XON/XOFF flow control?
>
> Or is something broken in the tty layer or uart driver?

tcflow(TCOxxx) flow control is independent of IXON flow control.
The union of both flow states determines if the tty can output;

                      IXON = true        IXON = false
                   START       STOP
tcflow(TCOON)      on         off          on
tcflow(TCOOFF)     off        off          off

Regards,
Peter Hurley

PS - The various flow states are not SMP-safe. I'm working to correct that.
