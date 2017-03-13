From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH] [v2][for 4.11]tty: acpi/spcr: QDF2400 E44 checks for
 wrong OEM revision
Date: Sun, 12 Mar 2017 23:19:16 -0500
Message-ID: <CAOZdJXUVz8w2tQdgQ1CyQC9XZL=Gig5kaSEb3b+3Yjap0ExfGg@mail.gmail.com>
References: <1488313833-12430-1-git-send-email-timur@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1488313833-12430-1-git-send-email-timur@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <greg@kroah.com>
Cc: dann.frazier@canonical.com, manoj.iyer@canonical.com, linux-serial@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Christopher Covington <cov@mykolab.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Feb 28, 2017 at 2:30 PM, Timur Tabi <timur@codeaurora.org> wrote:
> For Qualcomm Technologies QDF2400 SOCs that are affected by erratum E44,
> the ACPI oem_revision field is actually set to 1, not 0.
>
> Fixes: d8a4995bcea1 ("tty: pl011: Work around QDF2400 E44 stuck BUSY bit")
>
> Tested-by: Manoj Iyer <manoj.iyer@canonical.com>
> Signed-off-by: Timur Tabi <timur@codeaurora.org>

Greg, this is a critical fix for our platform.  Can you please pick it
up for 4.11-rc3?  Thank you.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
