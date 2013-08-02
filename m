From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: st-asc: Fix unused variable warning for non DT.
Date: Fri, 2 Aug 2013 11:55:59 +0800
Message-ID: <20130802035559.GA7092@kroah.com>
References: <1375351952-8185-1-git-send-email-srinivas.kandagatla@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:32956 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755029Ab3HBDyn (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 1 Aug 2013 23:54:43 -0400
Content-Disposition: inline
In-Reply-To: <1375351952-8185-1-git-send-email-srinivas.kandagatla@st.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Cc: linux-serial@vger.kernel.org

On Thu, Aug 01, 2013 at 11:12:32AM +0100, Srinivas KANDAGATLA wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> 
> This patch fixes a below warning reported by kbuild test robot from
> Greg.

It is not "my" test robot, please put the proper "Reported-by:" line in
this patch to give credit to the correct person.

> 
> tree:
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> head:   a54a4d5171bab310cb20fb62242ef87fa8443efb
> commit: c4b058560762ec7ffe159b668fc47a8b7e271949 [2237/2506]
> serial:st-asc: Add ST ASC driver.
> config: make ARCH=i386 allyesconfig

This isn't needed either.

thanks,

greg k-h
