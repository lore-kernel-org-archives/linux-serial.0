From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [RFC 1/8] serial:st-asc: Add ST ASC driver.
Date: Wed, 8 May 2013 09:15:27 -0700
Message-ID: <20130508161527.GA28080@kroah.com>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <1368022248-2153-1-git-send-email-srinivas.kandagatla@st.com>
 <201305081634.43498.arnd@arndb.de>
 <20130508153459.GA17186@kroah.com>
 <20130508154057.GB3041@game.jcrosoft.org>
 <20130508155301.GB27273@kroah.com>
 <B5A00B86-5332-427E-A82A-5B71EC0979A8@jcrosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <B5A00B86-5332-427E-A82A-5B71EC0979A8-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Srinivas KANDAGATLA <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Nicolas Pitre <nico-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Stephen Gallimore <stephen.gallimore-qxv4g6HH51o@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stuart Menefy <stuart.menefy-qxv4g6HH51o@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dong Aisheng <dong.aisheng-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, jslaby-AlSwsSmVLrQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Thu, May 09, 2013 at 12:03:05AM +0800, Jean-Christophe PLAGNIOL-VILLARD wrote:
> 
> On May 8, 2013, at 11:53 PM, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> wrote:
> 
> > On Wed, May 08, 2013 at 05:40:57PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >> On 08:34 Wed 08 May     , Greg KH wrote:
> >>> On Wed, May 08, 2013 at 04:34:43PM +0200, Arnd Bergmann wrote:
> >>>>> +#define ASC_MAJOR		204
> >>>>> +#define ASC_MINOR_START		40
> >>>> 
> >>>> I don't know what the current policy is on allocating major/minor numbers,
> >>>> but I'm sure you cannot just reuse one that is already used.
> >>> 
> >>> I agree, why are you trying to create a new tty device name?  Can't you
> >>> use the existing ttyS name and minor number as you will not have any
> >>> other type of serial device on this system?
> >> 
> >> Greg on ST STB for more than 10 years we use ttyASC I'll prefer ttySx
> > 
> > For 10+ years you have had an out-of-tree serial driver?
> yes ST have it out of tree for very long time even I puts them to come mainline

Crazy...

> >  What
> > major/minor numbers did you use for it?
> 
> http://git.stlinux.com/?p=havana/com.st.havana.kernel.git;a=blob;f=drivers/serial/stm-asc.h;h=79e003ffeb21df55a6af94774fc9c4b3d8de18e9;hb=HEAD
> 
>   52 #define ASC_MAJOR               204
>   53 #define ASC_MINOR_START         40
> 
> same as in this patch

Ok, but just because you have been using an out-of-tree name, and
non-reserved major/minor, doesn't mean we have to accept it.  As you are
probably using a tool like udev/devtmpfs on your systems, the
major/minor number shouldn't matter, only the name.

And I'd argue that we should change the name as well.

> >> on the DTB SoC you have one one IP present the st,asc
> > 
> > I don't understand, what do you mean by this?
> > 
> > confused,
> 
> just mention there is not hardware reason to not use the generic ttySx
> in place of ttyAS as we have only one IP that handle serial on this
> family of SoC
> 
> personally I'll switch to ttySx

Great, then you can use the same major/minor range as well, so there's
no more objection from me about this :)

thanks,

greg k-h
