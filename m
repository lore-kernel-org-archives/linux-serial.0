From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] serial/8250: fix uninitialized warnings
Date: Mon, 10 Nov 2008 16:19:55 -0800 (PST)
Message-ID: <20081110.161955.22624662.davem@davemloft.net>
References: <20081110143039.6f21fdc3.akpm@linux-foundation.org>
	<20081110234843.0fba9f16@lxorguk.ukuu.org.uk>
	<20081110155808.a4d94ee7.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:44078
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751759AbYKKAT4 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 10 Nov 2008 19:19:56 -0500
In-Reply-To: <20081110155808.a4d94ee7.akpm@linux-foundation.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: akpm@linux-foundation.org
Cc: alan@lxorguk.ukuu.org.uk, kosaki.motohiro@jp.fujitsu.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 10 Nov 2008 15:58:08 -0800

> On about half the architectures, BUG is not considered to be no-return.

Right, it ought to be, whether implicitly (__builtin_trap() is something
GCC considers no-return) or explicitly (if the arch uses inline
asm or the generic bug.h code)
