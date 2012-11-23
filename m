From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] tty: remove redundant initialization in
 initialize_tty_struct()
Date: Fri, 23 Nov 2012 14:51:07 +0000
Message-ID: <20121123145107.22bab04c@pyramind.ukuu.org.uk>
References: <1353681708-5413-1-git-send-email-clouds.yan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:38218 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312Ab2KWOpt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 23 Nov 2012 09:45:49 -0500
In-Reply-To: <1353681708-5413-1-git-send-email-clouds.yan@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Yan Hong <clouds.yan@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org

On Fri, 23 Nov 2012 22:41:47 +0800
Yan Hong <clouds.yan@gmail.com> wrote:

> tty_struct is already zeroed, no need to zero its field again.

True but its asking for impossible to find bugs later if this changes
