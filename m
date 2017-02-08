From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/2] tty: pl011: Work around QDF2400 E44 stuck BUSY bit
Date: Wed, 8 Feb 2017 13:33:06 +0000
Message-ID: <20170208133306.GE15459@leverpostej>
References: <20170208005736.18724-1-cov@codeaurora.org>
 <7151be59-000c-d50b-f8f5-5fef0c053d91@arm.com>
 <f9504cde-a87a-ba99-2f72-fc3029ef5fe5@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <f9504cde-a87a-ba99-2f72-fc3029ef5fe5@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Timur Tabi <timur@codeaurora.org>
Cc: Mark Salter <msalter@redhat.com>, Mark Langsdorf <mlangsdo@redhat.com>, Jon Masters <jcm@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Neil Leeder <nleeder@codeaurora.org>, linux-doc@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, shankerd@codeaurora.org, Christopher Covington <cov@codeaurora.org>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Wed, Feb 08, 2017 at 07:27:29AM -0600, Timur Tabi wrote:
> Robin Murphy wrote:

> >Are we to take it that every SoC now and always with any Kryo or Falkor
> >core which also has an SBSA UART will require this workaround?
> 
> No, only Kryo and Falkor V1 based SOCs have this problem.  Falkor V2
> will have this fixed.  We intend to revert these fixes after Falkor
> V1 SOCs are no longer supported.

Supported by whom?

Generally, once something's upstreamed we expect it to remain supported.

> > There's a
> >guarantee that the UART itself will definitely never be fixed in some
> >future revision? That it'll never be integrated into, say, some
> >Kryo/Cortex-Axx big.LITTLE system where you do still need the
> >workaround, but might be making this check on the wrong core?
> 
> We are sure that this erratum is restricted to those specific SOCs.

Ok. Then please identify the system as a whole (i.e. the SoC), and not
the CPU.

> >If there's really no suitable ID register to identify this particular
> >UART implementation, it probably needs to be described appropriately by
> >the firmware - I can't claim knowledge of how that works under ACPI, but
> >I do note that the only device ID currently being matched is "ARMH0011",
> >which seems to me to be inappropriate to describe something which is not
> >an ARM PL011, bugs or no bugs.
> 
> ACPI is not like device tree.  You can't just define a
> "qcom,needs-busy-bit-fix" property and call it a day.

ACPI and DT have pretty much the exact same set of issues w.r.t.
long term maintenance and support.

The important step is raising issues early, rather than shipping FW with
values that are not known to work (or known to not work)...

> If you're saying that we should create a new ACPI HID, like
> QCOM0011, that probably would have worked as well, except hindsight
> is 20/20, and we already have firmware in the field.

There are other way of identifying the system, if you look further than
the device.

Thanks,
Thanks.
