From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH] tty: acpi/spcr: QDF2400 E44 checks for wrong OEM revision
Date: Mon, 27 Feb 2017 22:11:57 -0600
Message-ID: <9a203593-3dcb-c730-52fd-6a2b79febf13@codeaurora.org>
References: <1488252276-2425-1-git-send-email-timur@codeaurora.org>
 <C6D2336E-DD53-43DB-B323-2BD00A17E298@mykolab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <C6D2336E-DD53-43DB-B323-2BD00A17E298@mykolab.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Christopher Covington <cov@mykolab.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>, manoj.iyer@canonical.com
List-Id: linux-serial@vger.kernel.org

Christopher Covington wrote:
> You might want to make this <= 1 and also change firmware to 0 so that new
> firmware with old kernels, new kernels with old firmware, and new kernels
> with new firmware all get the workaround applied.

I thought about that, but there is apparently no firmware that sets the value to 0.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
