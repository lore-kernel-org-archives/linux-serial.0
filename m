From: Alan Cox <alan@redhat.com>
Subject: Re: Moxa multi serial driver doesn't pass received chars up
Date: Thu, 2 Jun 2005 18:58:05 -0400
Message-ID: <20050602225805.GB9628@devserv.devel.redhat.com>
References: <200506021220.47138.vda@ilport.com.ua> <200506021554.07316.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:62348 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261438AbVFBW6a (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 2 Jun 2005 18:58:30 -0400
Content-Disposition: inline
In-Reply-To: <200506021554.07316.vda@ilport.com.ua>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, rmk+serial@arm.linux.org.uk, alan@redhat.com

On Thu, Jun 02, 2005 at 03:54:07PM +0300, Denis Vlasenko wrote:
> I am cooking a patch which will use
> tty_insert_flip_char(tty, ch, flag);

Cool. Thats the right way for it to work

