From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC] tty: pl011: Work around stuck BUSY bit on QDF2400
Date: Tue, 31 Jan 2017 14:51:12 +0000
Message-ID: <20170131145112.GF22283@arm.com>
References: <20170130234417.20855-1-cov@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170130234417.20855-1-cov@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Christopher Covington <cov@codeaurora.org>
Cc: pelcan@codeaurora.org, Peter Hurley <peter@hurleysoftware.com>, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, timur@codeaurora.org, Jiri Slaby <jslaby@suse.com>, linux-doc@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, nleeder@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Mon, Jan 30, 2017 at 06:44:17PM -0500, Christopher Covington wrote:
> N.B. I'm not confident that this patch is ready to be included as-is.
> Rather I'm hoping for guidance from reviewers and maintainers on
> broad implementation choices--whether A) the bitmask of flags to invert
> makes sense or B) vendor-specific is_busy() function pointers or C)
> hot-patching using the alternatives framework or D) some other
> approach would be best.
> 
> The Qualcomm Datacenter Technologies QDF2400 family of SoCs contains a
> custom (non-PrimeCell) implementation of the SBSA UART. Occasionally the
> BUSY bit in the Flag Register gets stuck as 1, erratum 44 for both 2432v1
> and 2400v1 SoCs. Checking that the Transmit FIFO Empty (TXFE) bit is 0,
> instead of checking that the BUSY bit is 1, works around the issue. To
> facilitate this substitution, introduce vendor-specific inversion of
> Feature Register bits.
> 
> Signed-off-by: Christopher Covington <cov@codeaurora.org>
> ---
> Based on https://git.kernel.org/cgit/linux/kernel/git/arm64/linux.git/log/?h=for-next/core
> ---
>  Documentation/arm64/silicon-errata.txt |  2 ++
>  arch/arm64/Kconfig                     | 11 +++++++++
>  arch/arm64/include/asm/cpucaps.h       |  3 ++-
>  arch/arm64/include/asm/cputype.h       |  2 ++
>  arch/arm64/kernel/cpu_errata.c         | 16 +++++++++++++

This isn't a bug in the CPU, so please don't reuse the CPU errata code to
workaround it. You can handle it all privately in the pl011 driver, but
do keep the update to silicon-errata.txt.

Will
