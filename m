From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] tty/serial: atmel_serial: fix compilation
Date: Sat, 29 Oct 2011 13:49:50 +0200
Message-ID: <20111029114950.GB22592@ponder.secretlab.ca>
References: <1319801631-14654-1-git-send-email-svens@stackframe.org>
 <4EAAA231.1020601@atmel.com> <20111028131811.GA25743@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20111028131811.GA25743-l3A5Bk7waGM@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sven Schnelle <svens-yWSVVCS59A8YeIxN5WHPnw@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Oct 28, 2011 at 03:18:11PM +0200, Greg KH wrote:
> On Fri, Oct 28, 2011 at 02:38:09PM +0200, Nicolas Ferre wrote:
> > On 10/28/2011 01:33 PM, Sven Schnelle :
> > > If CONFIG_OF is disabled, compilation fails with:
> > > 
> > > drivers/tty/serial/atmel_serial.c: In function 'atmel_serial_probe':
> > > drivers/tty/serial/atmel_serial.c:1788: error: implicit declaration of function 'of_alias_get_id'
> > > 
> > > Fix this by adding the proper CONFIG_OF checks.
> > 
> > Yes, but I would like to avoid this and I have made a patch to address
> > this issue. I have sent it to the device tree guys yesterday:
> > "[PATCH] dt: add empty of_alias_get_id() for non-dt builds"
> > 
> > Maybe we can wait a little and see if it reaches Linus' tree on time. If
> > it is not, I will make sure that such a fix make it to mainline.
> 
> I agree, the other dt: patch is the correct way to fix this, not this
> driver-only #ifdef hack.

I've picked up the of_alias_get_id patch now.

g.
