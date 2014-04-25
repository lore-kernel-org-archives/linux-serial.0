From: Charles Coldwell <coldwell@gmail.com>
Subject: Re: [PATCH v7 1/2] serial: sc16is7xx
Date: Fri, 25 Apr 2014 10:36:37 -0400 (EDT)
Message-ID: <alpine.LRH.2.03.1404251035560.2893@frank.harvard.edu>
References: <1398387367-4047-1-git-send-email-jon@ringle.org> <CAMwGMjyqiC1DLKfz0LUFg-iN8mDKc54w+8AYKFHOydiwtXHrFQ@mail.gmail.com> <alpine.LRH.2.03.1404251019300.2893@frank.harvard.edu> <1398436409.315304910@f193.i.mail.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398436409.315304910@f193.i.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Jon Ringle <jringle@gridpoint.com>, Jon Ringle <jon@ringle.org>
List-Id: linux-serial@vger.kernel.org

On Fri, 25 Apr 2014, Alexander Shiyan wrote:

> 
> At this stage, I would suggest just move the driver code into serial/8250
> to indicate the compatibility and then apply this patch and look for ways
> to optimize similar functions.

I suppose I could live with that.  This is really a wonderful UART,
and I would like to see it supported in some fashion.

-- 
Charles M. Coldwell, W1CMC
"Turn on, log in, tune out"
Somerville, Massachusetts, New England (FN42kj)

GPG ID:  852E052F
GPG FPR: 77E5 2B51 4907 F08A 7E92  DE80 AFA9 9A8F 852E 052F
