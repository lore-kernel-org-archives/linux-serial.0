From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] serial: sirf: Simplify a test
Date: Tue, 08 Nov 2016 12:41:26 +0100
Message-ID: <3381493.Qsc4sUWVSY@wuerfel>
References: <20161101070333.12255-1-christophe.jaillet@wanadoo.fr> <2916662.De1FDumaQl@wuerfel> <39a1050e-fb64-a6e5-8939-4e01631e59ea@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <39a1050e-fb64-a6e5-8939-4e01631e59ea@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-arm-kernel@lists.infradead.org, baohua@kernel.org, gregkh@linuxfoundation.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, jslaby@suse.com
List-Id: linux-serial@vger.kernel.org

On Tuesday, November 8, 2016 8:18:04 AM CET Christophe JAILLET wrote:
> Le 07/11/2016 à 14:50, Arnd Bergmann a écrit :
> > On Tuesday, November 1, 2016 8:03:33 AM CET Christophe JAILLET wrote:
> >> 'dmaengine_prep_dma_cyclic()' does not return an error pointer, so the test
> >> can be simplified to be more consistent.
> >>
> >> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > The change looks correct in principle. It would be good to automate looking
> > for other instances of this bug. How did you find it? Do you have e.g. a
> > coccinelle script or did you just stumble over the issue by accident?
> Hi,
> 
> You can have an idea of the strategy used in this post:
>     https://lkml.org/lkml/2016/11/1/388
> 
> Julia is currently working on a more complete strategy in order to find 
> such issues.

Ah, very nice!

	Arnd
