From: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
Subject: Re: [PATCH 5/5] Serial: UART driver changes for Cavium OCTEON.
Date: Tue, 02 Dec 2008 10:30:52 +0900
Message-ID: <49348FCC.1050404@necel.com>
References: <492C94FC.9070906@caviumnetworks.com> <1227658719-18297-5-git-send-email-ddaney@caviumnetworks.com> <492F6525.9010308@necel.com> <4934303F.1000509@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:42206 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753390AbYLBBbX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 1 Dec 2008 20:31:23 -0500
In-Reply-To: <4934303F.1000509@caviumnetworks.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: linux-serial@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, linux-mips@linux-mips.org, Tomaso Paoletti <tpaoletti@caviumnetworks.com>

David Daney wrote:
> ... All our boards are now working with no extra bug flags needed.  So I 
> will simplify this patch set by getting rid of UART_BUG_TIMEOUT.

Great! and makes sense.  Thank you for taking care of my comments.  I've
also checked the serial patches of version 2, and they looks in good
shape.

-- 
Shinya Kuribayashi
NEC Electronics
