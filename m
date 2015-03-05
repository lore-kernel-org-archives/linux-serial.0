From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH REPOST 0/2] Remove pl011 startup glitches and avoid dummy
 TX during startup
Date: Thu, 5 Mar 2015 12:03:20 +0000
Message-ID: <20150305120320.GB3612@e103592.cambridge.arm.com>
References: <1425472054-7543-1-git-send-email-Dave.Martin@arm.com>
 <54F73650.2070304@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <54F73650.2070304@arm.com>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andre Przywara <andre.przywara@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Jackson <Andrew.Jackson@arm.com>, Graeme Gregory <gg@slimlogic.co.uk>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Mar 04, 2015 at 04:44:00PM +0000, Andre Przywara wrote:
> Hi Dave,
> 
> On 04/03/15 12:27, Dave P Martin wrote:
> > There have been no comments on this series since my previous post, and
> > I have made no further changes.
> > 
> > Since then, I have confirmed that this also works robustly with TX DMA
> > enabled on Juno.
> > 
> > Review/comments/testing still welcome.
> 
> this has been tested briefly on a Calxeda Midway without any
> regressions. Also I use them as the base for my SBSA series now (which
> are tested on the model and the Midway) and I see that all problems
> observed before are gone now.
> 
> Tested-by: Andre Przywara <andre.przywara@arm.com>

Thanks -- should I take that for both patches?

Cheers
---Dave
