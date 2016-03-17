From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v4 2/4] ACPI: enable ACPI_SPCR_TABLE on ARM64
Date: Thu, 17 Mar 2016 12:20:37 -0500
Message-ID: <CAOZdJXV1KWyguPw33C+EF12TBDsg5Ds4AX-40gVefkhHwddW2g@mail.gmail.com>
References: <1456747355-15692-1-git-send-email-aleksey.makarov@linaro.org>
	<1456747355-15692-3-git-send-email-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1456747355-15692-3-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Yury Norov <ynorov@caviumnetworks.com>, Peter Hurley <peter@hurleysoftware.com>, "Zheng, Lv" <lv.zheng@intel.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
List-Id: linux-serial@vger.kernel.org

On Mon, Feb 29, 2016 at 6:02 AM, Aleksey Makarov
<aleksey.makarov@linaro.org> wrote:
> SBBR mentions SPCR as a mandatory ACPI table.
> So enable it for ARM64
>
> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>

Tested-by: Timur Tabi <timur@codeaurora.org>

I know another version of patch is coming, but I tested this version
and it works.
