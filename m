From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 5/7] serial: clps711x: fix IS_ERR_VALUE usage
Date: Wed, 17 Feb 2016 02:33:44 +0000
Message-ID: <20160217023344.GJ17997@ZenIV.linux.org.uk>
References: <1455546925-22119-1-git-send-email-a.hajda@samsung.com>
 <1455546925-22119-6-git-send-email-a.hajda@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455546925-22119-6-git-send-email-a.hajda@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Alexander Shiyan <shc_work@mail.ru>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Mon, Feb 15, 2016 at 03:35:23PM +0100, Andrzej Hajda wrote:
> IS_ERR_VALUE macro should be used only with unsigned long type.
> For signed types comparison 'ret < 0' should be used.

ACK
