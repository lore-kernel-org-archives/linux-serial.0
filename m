From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] moxa: do not ignore input
Date: Wed, 21 Jun 2006 12:51:44 +0100
Message-ID: <1150890705.15275.58.camel@localhost.localdomain>
References: <200506021220.47138.vda@ilport.com.ua>
	 <200506021554.07316.vda@ilport.com.ua>
	 <20050602225805.GB9628@devserv.devel.redhat.com>
	 <200506031601.21180.vda@ilport.com.ua>  <87y7vrpwzr.fsf@javad.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38887 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751332AbWFULhT (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 21 Jun 2006 07:37:19 -0400
In-Reply-To: <87y7vrpwzr.fsf@javad.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sergei Organov <osv@javad.com>
Cc: Denis Vlasenko <vda@ilport.com.ua>, Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, rmk+serial@arm.linux.org.uk

Ar Maw, 2006-06-20 am 21:17 +0400, ysgrifennodd Sergei Organov:
> This is on 2.6.14 kernel though, -- didn't try with more recent kernels
> as I have other troubles with them on my hardware/distribution.
> 
> Not a big deal, but you've asked yourself ;)

What does "dmesg" show for the Oops that caused the segfault ?

