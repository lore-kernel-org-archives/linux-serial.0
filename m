From: Jon Ringle <jon@ringle.org>
Subject: Re: [PATCH v7 1/2] serial: sc16is7xx
Date: Fri, 25 Apr 2014 10:11:18 -0400
Message-ID: <CAMwGMjy4HjP6y4YH8+OiNaU5cWEFsTOgATno3rhQPYUczzbcSw@mail.gmail.com>
References: <1398387367-4047-1-git-send-email-jon@ringle.org>
	<alpine.LRH.2.03.1404250914380.30160@frank.harvard.edu>
	<1398432935.28366949@f70.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398432935.28366949@f70.i.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Charles Coldwell <coldwell@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Jon Ringle <jringle@gridpoint.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Apr 25, 2014 at 9:35 AM, Alexander Shiyan <shc_work@mail.ru> wrote:
> And it would be nice to have a small changelog,
> because it is unclear what has changed with version 6.

v7 was created at Greg's request to refresh the patch. The only
conflict that required code change was in serial_core.h changing
#define PORT_SC16IS7XX 107
to
#define PORT_SC16IS7XX 108

Jon
