From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] serial: samsung: Fix compile error with
 SERIAL_SAMSUNG_DEBUG
Date: Sun, 15 Jun 2014 10:46:56 -0700
Message-ID: <1402854416.2695.12.camel@joe-AO725>
References: <1402776434-31613-1-git-send-email-cengelma@gmx.at>
	 <1402778036.2756.24.camel@joe-AO725>
	 <CAK5sBcGu2vFQFxqETgbLnu0AoMAhn9Zq5SEWNNzX=mr0yuWRdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtprelay0237.hostedemail.com ([216.40.44.237]:58301 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751723AbaFORrA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 15 Jun 2014 13:47:00 -0400
In-Reply-To: <CAK5sBcGu2vFQFxqETgbLnu0AoMAhn9Zq5SEWNNzX=mr0yuWRdg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sachin Kamat <spk.linux@gmail.com>
Cc: Christian Engelmayer <cengelma@gmx.at>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Jingoo Han <jg1.han@samsung.com>, linux-kernel@vger.kernel.org

On Sun, 2014-06-15 at 23:06 +0530, Sachin Kamat wrote:
> On Sun, Jun 15, 2014 at 2:03 AM, Joe Perches <joe@perches.com> wrote:
> > Greg?  Can you please apply this soon?
> 
> A similar patch has already been posted [1]. Probably Greg will apply it
> once 3.16-rc1 is out.
> 
> [1] http://www.spinics.net/lists/linux-serial/msg12843.html

I know.  It was just another prompt to Greg.

It's just unfortunate to have a compile failure path
in Linus' tree.  Especially one I introduced.

He'd said 10 days ago or so it'd be a day or two.

http://www.spinics.net/lists/linux-serial/msg12859.html

cheers, Joe

