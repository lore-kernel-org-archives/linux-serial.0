From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/3] pty: Lock the devpts bits privately
Date: Tue, 08 May 2012 13:41:34 -0700
Message-ID: <4FA984FE.1040801@zytor.com>
References: <20120503212151.568.91854.stgit@bob.linux.org.uk> <20120503212205.568.25804.stgit@bob.linux.org.uk> <4FA9637B.1060609@zytor.com> <20120508214309.2d50e5f0@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:33509 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752489Ab2EHUlt (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 8 May 2012 16:41:49 -0400
In-Reply-To: <20120508214309.2d50e5f0@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On 05/08/2012 01:43 PM, Alan Cox wrote:
> 
> One step at a time. I agree entirely that the ideal case is that
> devpts_foo is internally locked and coherent. That is an exercise for
> someone who likes devpts 8)
> 

OK.  I can look at that later; this should detach it enough from the tty
locking that the rest is easy.

	-hpa


