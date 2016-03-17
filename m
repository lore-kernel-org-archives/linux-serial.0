From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v4 1/4] ACPI: parse SPCR and enable matching console
Date: Thu, 17 Mar 2016 12:20:05 -0500
Message-ID: <CAOZdJXVkA8Rbxe-ExL7mYQ=gib-0YPmoizXds3+0SFB9DBx0QA@mail.gmail.com>
References: <1456747355-15692-1-git-send-email-aleksey.makarov@linaro.org>
	<1456747355-15692-2-git-send-email-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1456747355-15692-2-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Yury Norov <ynorov@caviumnetworks.com>, Peter Hurley <peter@hurleysoftware.com>, "Zheng, Lv" <lv.zheng@intel.com>, Len Brown <lenb@kernel.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On Mon, Feb 29, 2016 at 6:02 AM, Aleksey Makarov
<aleksey.makarov@linaro.org> wrote:
> 'ARM Server Base Boot Requiremets' [1] mentions SPCR (Serial Port
> Console Redirection Table) [2] as a mandatory ACPI table that
> specifies the configuration of serial console.
>
> Parse this table and check if any registered console match the
> description.  If it does, enable that console.
>
> Introduce a new function acpi_console_check().  At the uart port
> registration, this function checks if the ACPI SPCR table specifies
> its argument of type struct uart_port to be a console
> and if so calls add_preferred_console().
>
> [1] http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0044a/index.html
> [2] http://msdn.microsoft.com/en-us/library/windows/hardware/dn639131(v=vs.85).aspx
>
> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>

Tested-by: Timur Tabi <timur@codeaurora.org>

I know another version of patch is coming, but I tested this version
and it works.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
