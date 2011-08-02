From: Breno Leitao <leitao@linux.vnet.ibm.com>
Subject: Re: Very strange data loss with jsm driver
Date: Tue, 02 Aug 2011 11:49:27 -0300
Message-ID: <4E380E77.1040702@linux.vnet.ibm.com>
References: <20110729160416.GK8562@caffeine.csclub.uwaterloo.ca> <20110729172736.4b199d31@lxorguk.ukuu.org.uk> <20110729165342.GB8566@caffeine.csclub.uwaterloo.ca> <20110729180650.GL8562@caffeine.csclub.uwaterloo.ca> <20110729191442.35d09111@lxorguk.ukuu.org.uk> <20110729181337.GM8562@caffeine.csclub.uwaterloo.ca> <4E380710.1010204@linux.vnet.ibm.com> <20110802142225.GO8562@caffeine.csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from e24smtp04.br.ibm.com ([32.104.18.25]:45067 "EHLO
	e24smtp04.br.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753387Ab1HBOuY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 2 Aug 2011 10:50:24 -0400
Received: from /spool/local
	by br.ibm.com with XMail ESMTP
	for <linux-serial@vger.kernel.org> from <leitao@linux.vnet.ibm.com>;
	Tue, 2 Aug 2011 11:50:22 -0300
In-Reply-To: <20110802142225.GO8562@caffeine.csclub.uwaterloo.ca>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On 08/02/2011 11:22 AM, Lennart Sorensen wrote:
>  On Tue, Aug 02, 2011 at 11:17:52AM -0300, Breno Leitao wrote:
> > Well, I finally tested it over here, and what I found is:
> >
> > If the line has a \r among the first 16 bytes, then the information
> > is TXed immediately. If there is no \r in the first 16 bytes, then the
> > information seems to be buffered.
>
>  Where in the driver is this happening?
Well, I just found it doing some test cases.

Enabling the driver debug, I found that ->intr is not being called on
the "incorrect" case.

This is the diff of the logs:

  jsm 0005:02:00.0: finish
  jsm 0005:02:00.0: start
  jsm 0005:02:00.0: finish
-jsm 0005:02:00.0: drivers/tty/serial/jsm/jsm_neo.c:1131 uart_poll: 301
-jsm 0005:02:00.0: drivers/tty/serial/jsm/jsm_neo.c:1161 port: 0 type: 3
-jsm 0005:02:00.0: drivers/tty/serial/jsm/jsm_neo.c:750 isr: 2
-jsm 0005:02:00.0: MOD_STAT: sending to parse_modem_sigs
-jsm 0005:02:00.0: neo_parse_modem: port: 0 msignals: 0
-jsm 0005:02:00.0: Port: 0 DTR: 0 RTS: 0 CTS: 0 DSR: 0 RI: 0 CD: 0
  jsm 0005:02:00.0: start
  jsm 0005:02:00.0: Close. HUPCL set, dropping DTR/RTS
  jsm 0005:02:00.0: finish
-jsm 0005:02:00.0: finish.

Anyway, I am still debugging it.

PS: I will look at the stats regression after I fix this one, ok ?

