From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC PATCH 1/6] Documentation: arm: ti: Add bindings for AM654 SoC
Date: Tue, 12 Jun 2018 17:01:25 -0500
Message-ID: <20180612220125.3scgr6by62wifirp@kahuna>
References: <20180605060125.9518-1-nm@ti.com> <20180605060125.9518-2-nm@ti.com>
 <20180612210519.GA17653@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180612210519.GA17653@rob-hp-laptop>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Vignesh R <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Santosh Shilimkar <ssantosh@kernel.org>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Tero Kristo <t-kristo@ti.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 21:05-20180612, Rob Herring wrote:
> On Tue, Jun 05, 2018 at 01:01:20AM -0500, Nishanth Menon wrote:
[...]
> > +Boards based on K3 Multicore SoC architecture shall have the following property:
> > +- compatible: Every hardware block introduced in K3 Multicore SoC
> > +  architecture shall be of the form:
> > +  "ti,XXX-YYY", where:
> > +     'XXX' represents the specific SoC part for which the support is added.
> > +     'YYY' represents the corresponding peripheral in SoC being supported.
> 
> No need to explain standard DT convention here. (But I don't think we 
> have this convention documented anywhere, so patches welcome. :))
> 

Thanks. Will drop off from my series (will skip the generic dts
convention for now ;) ).
-- 
Regards,
Nishanth Menon
