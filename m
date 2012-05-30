From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: [PATCH] serial: samsung: protect NULL dereference of clock name
Date: Wed, 30 May 2012 14:37:56 +0530
Message-ID: <CAM=Q2csPTE=5sc+kxnW6d+trf04OknFtRoxq4NGu8PkoAhOOxg@mail.gmail.com>
References: <001401cd3e3e$644fd3a0$2cef7ae0$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <001401cd3e3e$644fd3a0$2cef7ae0$%kim@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kyoungil Kim <ki0351.kim@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Alan Cox <alan@linux.intel.com>, KeyYoung Park <keyyoung.park@samsung.com>, Huisung Kang <hs1218.kang@samsung.com>
List-Id: linux-serial@vger.kernel.org

Hi Kim,
On Wed, May 30, 2012 at 1:59 PM, Kyoungil Kim <ki0351.kim@samsung.com> wrote:
> From: KeyYoung Park <keyyoung.park@samsung.com>
>
> When priting the serial clock source, if clock source name is null,
> kernel reference NULL point.
>
Could you help me understand why is that NULL ? Or the crash that you saw.
