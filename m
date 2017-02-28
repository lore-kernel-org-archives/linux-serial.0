From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH] tty: acpi/spcr: QDF2400 E44 checks for wrong OEM revision
Date: Tue, 28 Feb 2017 14:23:03 -0600
Message-ID: <ad478756-9b4d-79a0-1da3-a2265ba7ec49@codeaurora.org>
References: <1488252276-2425-1-git-send-email-timur@codeaurora.org>
 <CALdTtnsbh3fZF+Ci1JmQ=Awod5QPWB4+gTRWx0u9=xyaLfhNmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CALdTtnsbh3fZF+Ci1JmQ=Awod5QPWB4+gTRWx0u9=xyaLfhNmw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: dann frazier <dann.frazier@canonical.com>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Manoj Iyer <manoj.iyer@canonical.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, cov@mykolab.com
List-Id: linux-serial@vger.kernel.org

On 02/28/2017 02:19 PM, dann frazier wrote:
> On Mon, Feb 27, 2017 at 8:24 PM, Timur Tabi <timur@codeaurora.org> wrote:
>> For Qualcomm Technologies QDF2400 SOCs that are affected by
>> erratum E44, the ACPI oem_revision field is actually set to 1,
>> not 0.
>
> Should this 'Fixes: d8a4995bcea1 ("PCI: Add ACS quirk for Qualcomm
> QDF2400 and QDF2432")' ?

Fixes: d8a4995bcea1 ("tty: pl011: Work around QDF2400 E44 stuck BUSY bit")

I will post a v2.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
