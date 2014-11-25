From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V3 0/7] serial: Configure {big,native}-endian MMIO
 accesses via DT
Date: Tue, 25 Nov 2014 09:38:59 -0800
Message-ID: <20141125173859.GA27287@kroah.com>
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
 <20141125151018.359EAC44343@trevor.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <20141125151018.359EAC44343@trevor.secretlab.ca>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Grant Likely <grant.likely@linaro.org>
Cc: Kevin Cernekee <cernekee@gmail.com>, jslaby@suse.cz, robh@kernel.org, arnd@arndb.de, f.fainelli@gmail.com, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-mips@linux-mips.org
List-Id: linux-serial@vger.kernel.org

On Tue, Nov 25, 2014 at 03:10:18PM +0000, Grant Likely wrote:
> On Mon, 24 Nov 2014 15:36:15 -0800
> , Kevin Cernekee <cernekee@gmail.com>
>  wrote:
> > My last submission attempted to work around serial driver coexistence
> > problems on multiplatform kernels.  Since there are still questions
> > surrounding the best way to solve that problem, this patch series
> > will focus on the narrower topic of big endian MMIO support on serial.
> > 
> > 
> > V2->V3:
> > 
> >  - Document the new DT properties.
> > 
> >  - Add libfdt-based wrapper, to complement the "struct device_node" based
> >    version.
> > 
> >  - Restructure early_init_dt_scan_chosen_serial() changes to use a
> >    temporary variable, so it is easy to add more of_setup_earlycon()
> >    properties later.
> > 
> >  - Make of_serial and serial8250 honor the new "big-endian" property.
> > 
> > 
> > This series applies cleanly to:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/glikely/linux.git devicetree/next-overlay
> > 
> > but was tested on the mips-for-linux-next branch because my BE platform
> > isn't supported in mainline yet.
> 
> For the whole series:
> Acked-by: Grant Likely <grant.likely@linaro.org>
> 
> Greg, which tree do you want to merge this through? My DT tree, or the
> tty tree?

I can take these through my tty tree, thanks.

greg k-h
