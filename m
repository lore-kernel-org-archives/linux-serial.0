From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH 1/4] OF: Add helper for matching against linux,stdout-path
Date: Thu, 22 Nov 2012 06:41:38 +0100
Message-ID: <20121122054138.GY4398@game.jcrosoft.org>
References: <20121121155312.GX4398@game.jcrosoft.org>
 <1353513428-25697-1-git-send-email-plagnioj@jcrosoft.com>
 <CACxGe6tyPpjx4OtjHmhB9Cvnb7OwAjPEE4=K+wgWKYHcAV-ESQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CACxGe6tyPpjx4OtjHmhB9Cvnb7OwAjPEE4=K+wgWKYHcAV-ESQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree-discuss <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Sascha Hauer <kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On 18:03 Wed 21 Nov     , Grant Likely wrote:
> On Wed, Nov 21, 2012 at 3:57 PM, Jean-Christophe PLAGNIOL-VILLARD
> <plagnioj@jcrosoft.com> wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> >
> > devicetrees may have a linux,stdout-path or stdout-path property
> > in the chosen node describing the console device. This adds a helper
> > function to match a device against this property and retrieve the options
> > so a driver can call add_preferred_console for a matching device.
> 
> NIce. Looks like the right behaviour, but is a little inefficient.
> Since the stdout property doesn't change this code could be called
> once right after the tree is unflattened and then cache the pointer to
> the node anarguments. Can you add the code to of_alias_scan()?
do we assume that we can have only one stdout-path?

I think we could have more serial, framebuffer console

Best Regards,
J.
