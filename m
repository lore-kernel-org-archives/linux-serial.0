From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] Powerpc 8xx CPM_UART delay in receive
Date: Thu, 16 Aug 2012 16:21:36 +0100
Message-ID: <20120816162136.059b64b4@bob.linux.org.uk>
References: <201208141426.q7EEQSPc003956@localhost.localdomain>
	<20120814155227.018988da@pyramind.ukuu.org.uk>
	<502CF2A0.8080109@c-s.fr>
	<20120816152918.5ed2649f@pyramind.ukuu.org.uk>
	<502D054B.3010606@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:26420 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751524Ab2HPPEJ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 16 Aug 2012 11:04:09 -0400
In-Reply-To: <502D054B.3010606@c-s.fr>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: leroy christophe <christophe.leroy@c-s.fr>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Vitaly Bordug <vitb@kernel.crashing.org>, Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

> MAX_IDL: Maximum idle characters. When a character is received, the=20
> receiver begins counting idle characters. If MAX_IDL idle characters
> are received before the next data character, an idle timeout occurs
> and the buffer is closed,
> generating a maskable interrupt request to the core to receive the
> data from the buffer. Thus, MAX_IDL offers a way to demarcate frames.
> To disable the feature, clear MAX_IDL. The bit length of an idle
> character is calculated as follows: 1 + data length (5=969) + 1 (if
> parity is used)=20
> + number of stop bits (1=962). For 8 data bits, no parity, and 1 stop
> bit, the character length is 10 bits


So if you have slightly bursty high speed data as its quite typical
before your change you would get one interrupt per buffer of 32 bytes,
with it you'll get a lot more interrupts.

You have two available hints about the way to set this - one of them is
the baud rate (low baud rates mean the fifo isn't a big win and the
latency is high), the other is the low_latency flag if the driver
supports the low latency feature (and arguably you can still use a
request for it as a hint even if you refuse the actual feature).

So I think a reasonable approach would be set the idle timeout down for
low baud rates or if low_latency is requested.

> generated if there is at least one word in the FIFO and for a time=20
> equivalent to the transmission of four characters

Which is a bit more reasonable than one, although problematic at low
speed (hence the fifo on/off).


--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
