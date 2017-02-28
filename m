From: Christopher Covington <cov@mykolab.com>
Subject: Re: [PATCH] tty: acpi/spcr: QDF2400 E44 checks for wrong OEM revision
Date: Mon, 27 Feb 2017 20:02:44 -0800
Message-ID: <C6D2336E-DD53-43DB-B323-2BD00A17E298@mykolab.com>
References: <1488252276-2425-1-git-send-email-timur@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1488252276-2425-1-git-send-email-timur@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Timur Tabi <timur@codeaurora.org>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>, manoj.iyer@canonical.com
List-Id: linux-serial@vger.kernel.org




>--- a/drivers/acpi/spcr.c
>+++ b/drivers/acpi/spcr.c
>@@ -30,7 +30,7 @@ static bool qdf2400_erratum_44_present(struct
>acpi_table_header *h)
> 		return true;
> 
> 	if (!memcmp(h->oem_table_id, "QDF2400 ", ACPI_OEM_TABLE_ID_SIZE) &&
>-			h->oem_revision == 0)
>+			h->oem_revision == 1)

You might want to make this <= 1 and also change firmware to 0 so that new firmware with old kernels, new kernels with old firmware, and new kernels with new firmware all get the workaround applied.

Regards,
Cov

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
