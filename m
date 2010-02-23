From: Breno Leitao <leitao@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] jsm: removing the uart structure and filename on
 error
Date: Tue, 23 Feb 2010 17:27:36 -0300
Message-ID: <4B843A38.7030404@linux.vnet.ibm.com>
References: <ca4d83709f14810b7ae9a3d1567f0ae370eb9ad0.1265074258.git.root@devhv4e-phantom-lp3.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from e24smtp03.br.ibm.com ([32.104.18.24]:43030 "EHLO
	e24smtp03.br.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753556Ab0BWU1l (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 23 Feb 2010 15:27:41 -0500
Received: from mailhub1.br.ibm.com (mailhub1.br.ibm.com [9.18.232.109])
	by e24smtp03.br.ibm.com (8.14.3/8.13.1) with ESMTP id o1NKNDd4023300
	for <linux-serial@vger.kernel.org>; Tue, 23 Feb 2010 17:23:13 -0300
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
	by mailhub1.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o1NKUPf91085606
	for <linux-serial@vger.kernel.org>; Tue, 23 Feb 2010 17:30:26 -0300
Received: from d24av03.br.ibm.com (loopback [127.0.0.1])
	by d24av03.br.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id o1NKRaFu031541
	for <linux-serial@vger.kernel.org>; Tue, 23 Feb 2010 17:27:37 -0300
In-Reply-To: <ca4d83709f14810b7ae9a3d1567f0ae370eb9ad0.1265074258.git.root@devhv4e-phantom-lp3.austin.ibm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-serial@vger.kernel.org, scottk@digi.com

Greg, 

I sent this patch almost a month ago, and I didn't hear from Scott.
What are the next steps here now ? Could you apply it directly since
this is a pretty trivial patch ?

Thanks, 
Breno

leitao@linux.vnet.ibm.com wrote:
> If jsm fails to load, then remove the uart stuff, otherwise,
> the things (as files), will be there forever (even when the module
> is unloaded). If you try to reload the module, the following message
> appears:
> 

