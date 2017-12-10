From: Jon Masters <jcm@jonmasters.org>
Subject: Re: [PATCH 0/2] acpi, x86: Add SPCR table support
Date: Sun, 10 Dec 2017 15:40:08 -0500
Message-ID: <d3c46a6f-745c-7643-c55f-781a6ffea8f4@jonmasters.org>
References: <20171207172912.17868-1-prarit@redhat.com>
 <20171208062925.64ov23u7oxmdfzyk@gmail.com>
 <f078ada7-1e30-41cc-28dc-077ed2a5986d@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <f078ada7-1e30-41cc-28dc-077ed2a5986d@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Prarit Bhargava <prarit@redhat.com>, Ingo Molnar <mingo@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, x86@kernel.org, linux-pm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, linux-doc@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lv Zheng <lv.zheng@intel.com>, linux-serial@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 12/08/2017 09:29 AM, Prarit Bhargava wrote:

> If I disable "Serial Port Console Debug" in my BIOS I still see the SPCR configured:
> 
> [root@prarit-lab ~]# dmesg | grep SPCR
> [    0.000000] ACPI: SPCR 0x0000000069031000 000050 (v01
> 00000000      00000000)
> 
> AFAICT the SPCR is always enabled on some systems.

It's part of some of the Windows design flows that it gets incorporated,
and it should always be present.

Jon (not talking about AArch64/ARM/arm/ARMv8-A/64-bit ARM/Go ARM Go).
