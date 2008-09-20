From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] max3100 driver
Date: Sat, 20 Sep 2008 15:34:12 +0100
Message-ID: <20080920153412.15e26a93@lxorguk.ukuu.org.uk>
References: <1221895208650-git-send-email-chripell@gmail.com>
	<20080920012454.e40f03cc.akpm@linux-foundation.org>
	<20080920065652.11d76780@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:43962 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751128AbYITOfA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 20 Sep 2008 10:35:00 -0400
In-Reply-To: <20080920065652.11d76780@infradead.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christian Pellegrin <chripell@gmail.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Christian Pellegrin <chripell@fsfe.org>

> I do have a question though: what does a signed bitfield of 1 mean?
> I mean.. the variables are "int", so signed.... where will the compiler
> store the sign bit???

It sign extends so you get 0 or -1. Yes it would be good to use unsigned
to avoid suprises.
