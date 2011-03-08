From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] n_gsm: improve behaviour with encoding 0
Date: Tue, 8 Mar 2011 19:52:02 +0000
Message-ID: <20110308195202.20ef135e@lxorguk.ukuu.org.uk>
References: <1299543872-14580-1-git-send-email-eric@eukrea.com>
	<20110308130145.3bacbe1b@lxorguk.ukuu.org.uk>
	<4D765658.7070301@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55095 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755645Ab1CHTv4 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 8 Mar 2011 14:51:56 -0500
In-Reply-To: <4D765658.7070301@eukrea.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Eric =?ISO-8859-14?B?QuluYXJk?= <eric@eukrea.com>
Cc: linux-serial@vger.kernel.org

> I attach the log for the 2 following case :
> - Simcom SIM300 : mux establish fine, pppd launch and the link establish (I 
> interrupted the process), a serial terminal can talk to the modem and get answer,
> - Telit UC864E : mux establish fine, pppd blocks after sending AT, a serial 
> terminal can talk to the modem and get answer so I don't understand why chat 
> fails,

First guess would be to try fiddling the flow control, could be the modem
for some reason thinks it is currently flow controlled ?

Alan
