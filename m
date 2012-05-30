From: Kyoungil Kim <ki0351.kim@samsung.com>
Subject: RE: [PATCH] serial: samsung: protect NULL dereference of clock name
Date: Wed, 30 May 2012 18:28:03 +0900
Message-ID: <001701cd3e46$8372bce0$8a5836a0$%kim@samsung.com>
References: <001401cd3e3e$644fd3a0$2cef7ae0$%kim@samsung.com>
 <CAM=Q2csPTE=5sc+kxnW6d+trf04OknFtRoxq4NGu8PkoAhOOxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:36675 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932381Ab2E3J2G (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 30 May 2012 05:28:06 -0400
In-reply-to: <CAM=Q2csPTE=5sc+kxnW6d+trf04OknFtRoxq4NGu8PkoAhOOxg@mail.gmail.com>
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Shubhrajyoti Datta' <omaplinuxkernel@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Alan Cox' <alan@linux.intel.com>, 'KeyYoung Park' <keyyoung.park@samsung.com>, 'Huisung Kang' <hs1218.kang@samsung.com>

Shubhrajyoti Datta wrote:
> Hi Kim,
> On Wed, May 30, 2012 at 1:59 PM, Kyoungil Kim <ki0351.kim@samsung.com> wrote:
> > From: KeyYoung Park <keyyoung.park@samsung.com>
> >
> > When priting the serial clock source, if clock source name is null,
> > kernel reference NULL point.
> >
> Could you help me understand why is that NULL ? Or the crash that you saw.

When you want to see the serial clock source name like using cat command before you open the tty, 
You can see the kernel crash.
I know this is not normal scenario.
This patch just prevents the kernel panic.

