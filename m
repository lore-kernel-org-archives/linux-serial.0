From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH v13 5/5] uart: pl011: Add support to ZTE ZX296702 uart
Date: Mon, 26 Oct 2015 10:31:07 -0500
Message-ID: <562E473B.6070504@tabi.org>
References: <1438328959-16177-1-git-send-email-jun.nie@linaro.org>
 <1438328959-16177-6-git-send-email-jun.nie@linaro.org>
 <55FC16A2.5070207@arm.com>
 <CABymUCOA3oG7Hq83hDyQ_uisQHeipoHshcWONWTtjxKvikzjsQ@mail.gmail.com>
 <CAOZdJXUjZLKkUYScD7oDTMuRUtAEJ6=DopmE4n6Vb9zyv+_viA@mail.gmail.com>
 <CABymUCORU9CDD64Rdw2VX0kLSe6E1zY9iZCap5xittoVFwbOtw@mail.gmail.com>
 <562AFBD5.3050508@codeaurora.org> <562DF96D.6020307@arm.com>
 <562E20B2.4050805@codeaurora.org> <562E3213.8070602@arm.com>
 <562E33AE.2020608@codeaurora.org> <562E3BCF.7010000@arm.com>
 <562E3D02.2040108@codeaurora.org> <562E447E.6070703@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <562E447E.6070703@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andre Przywara <andre.przywara@arm.com>, Jun Nie <jun.nie@linaro.org>
Cc: "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "peter@hurleysoftware.com" <peter@hurleysoftware.com>, "jason.liu@linaro.org" <jason.liu@linaro.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Andrew Jackson <Andrew.Jackson@arm.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "wan.zhijun@zte.com.cn" <wan.zhijun@zte.com.cn>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On 10/26/2015 10:19 AM, Andre Przywara wrote:

>> We have an internal patch that I'm trying to upstream, but I need the
>> amba-pl011 driver to stabilize first.
>
> As mentioned earlier, this looks like the perfect opportunity now to get
> the change in (since I see it as a subset of Jun's series). "Waiting for
> stabilization" sounds a bit optimistic to me in a general Linux context ;-)

I will post it today.

>> We use ACPI bindings.  It's our ARM64 server-class SOC.  We use the ACPI
>> subtype 13 to identify it.
>
> Does "subtype 13" refer to the UUID field here? So instead of using UUID
> 0 you have some vendor specific field set in your ARMH0011 table? Is
> that "just made up" or specified somewhere so that there will be no
> other usage of that number later?

It's part of the ARMH0011 table.  There are already a couple subtypes, 
but a bunch more were added.  It's table 3 in this document: 
http://go.microsoft.com/fwlink/p/?linkid=403551

Notice how the new subtype is already deprecated.  That's because it's 
technically a bug for hardware to require 32-bit accesses.
