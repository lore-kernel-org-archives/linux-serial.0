From: Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH DRAFT 1/2] drivers: serial: PL011: refactor register access
Date: Mon, 2 Nov 2015 13:40:25 +0000
Message-ID: <563767C9.7050206@arm.com>
References: <1446467042-24494-1-git-send-email-andre.przywara@arm.com>
 <1446467042-24494-2-git-send-email-andre.przywara@arm.com>
 <563764B7.6040202@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <563764B7.6040202@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Timur Tabi <timur@codeaurora.org>, Jun Nie <jun.nie@linaro.org>, Peter Hurley <peter@hurleysoftware.com>
Cc: Andrew.Jackson@arm.com, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Timur,

On 02/11/15 13:27, Timur Tabi wrote:
> Andre Przywara wrote:
>> * to support UARTs with different register offsets (ZTE)
>> * to support a different bus access width (16 bits vs. 32 bits)
> 
> How exactly does this patch provide this?  The code is still calling a
> fixed function.  How will the code dynamically call a 32-bit version
> instead of a 16-bit version on platforms that need it?

This patch doesn't, I was just enumerating possible extensions which
will become much easier now that we don't have to patch every single
call site for such a change (to give rationale for this refactoring).
Changing the access width is now a simple change in those two functions,
and since you have the struct uart_amba_port available, you can access
any field in there to determine your desired access width.

As it says on the tin: it's a draft. Feel free to extend it to a proper
series ;-)

Cheers,
Andre.
