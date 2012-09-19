From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] 8250: fix autoconfig to work with serial console
Date: Wed, 19 Sep 2012 15:02:23 +0100
Message-ID: <20120919150223.0fc75225@pyramind.ukuu.org.uk>
References: <1347996092-30957-1-git-send-email-fbl@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:36209 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753244Ab2ISN5d (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 19 Sep 2012 09:57:33 -0400
In-Reply-To: <1347996092-30957-1-git-send-email-fbl@redhat.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Flavio Leitner <fbl@redhat.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 18 Sep 2012 16:21:32 -0300
Flavio Leitner <fbl@redhat.com> wrote:

> The autoconfig prints messages while holding the
> port's spinlock and that causes a deadlock when
> using serial console.

Doing autoconfig on your serial console while in use is insane, but it
shouldn't crash the system either.

Acked-by: Alan Cox <alan@linux.intel.com>

