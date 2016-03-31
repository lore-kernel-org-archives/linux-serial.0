From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/4] tty: vt, remove reduntant check
Date: Thu, 31 Mar 2016 15:23:31 +0100
Message-ID: <20160331152331.4bba3925@lxorguk.ukuu.org.uk>
References: <1459411697-26019-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459411697-26019-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, 31 Mar 2016 10:08:14 +0200
Jiri Slaby <jslaby@suse.cz> wrote:

> MAX_NR_CONSOLES and MAX_NR_USER_CONSOLES are both 63 since they were
> introduced in 1.1.54. And since vc_allocate does:
> 
> if (currcons >= MAX_NR_CONSOLES)
> 	return -ENXIO;
> 
> if (!vc_cons[currcons].d) {
> 	if (currcons >= MAX_NR_USER_CONSOLES && !capable(CAP_SYS_RESOURCE))
> 		return -EPERM;
> }
> 
> the second check is pointless. Remove both the check and the macro
> MAX_NR_USER_CONSOLES.

NAK

There are embedded people who do change these values.
