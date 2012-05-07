From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: What's the rationale behind sending a Xoff character when the
 port is stopped ?
Date: Mon, 7 May 2012 21:50:59 +0100
Message-ID: <20120507215059.3111018f@pyramind.ukuu.org.uk>
References: <CAES2cWwz=JJY14rCX8_GwnD7Mgmweiz9xSUsw6z08YZ2zNHkqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:33880 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932146Ab2EGUsJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 7 May 2012 16:48:09 -0400
In-Reply-To: <CAES2cWwz=JJY14rCX8_GwnD7Mgmweiz9xSUsw6z08YZ2zNHkqw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Karthik Manamcheri <karthik.manamcheri@gmail.com>
Cc: linux-serial@vger.kernel.org

On Mon, 7 May 2012 15:00:50 -0500
Karthik Manamcheri <karthik.manamcheri@gmail.com> wrote:

> Hi,
> 
> I noticed in drivers/tty/serial/8250.c that when we transmit
> characters (by calling transmit_chars), we check for uart_tx_stopped
> only after sending the x_char (if any). What's the rationale behind
> this ? I would expect the uart not to send ANY characters (including a
> Xoff character) if its throttled (or stopped).

We implement xon/xoff flow control. Therefore we need to send characters
when throttled.

Think about the case where you are flow controlled for transmit and your
receive buffer fills up...

Alan
