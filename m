From: Christopher Covington <cov@codeaurora.org>
Subject: Re: [PATCH v3 0/5] ACPI: parse the SPCR table
Date: Tue, 16 Feb 2016 21:36:10 -0500
Message-ID: <FD7CEA09-FFB5-4707-A4AE-7F721491C327@codeaurora.org>
References: <1455559532-8305-1-git-send-email-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1455559532-8305-1-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>, linux-acpi@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>
List-Id: linux-serial@vger.kernel.org



On February 15, 2016 1:05:24 PM EST, Aleksey Makarov <aleksey.makarov@linaro.org> wrote:
>This patchset is based on the patchset by Leif Lindholm [1]
>
>'ARM Server Base Boot Requirements' [2] mentions SPCR (Serial Port
>Console Redirection Table) [3] as a mandatory ACPI table that
>specifies the configuration of serial console.
>
>SPCR support is included in QEMU's ARM mach-virt since 2.4 release.
>
>Introduce a new function acpi_console_check().  At the uart port
>registration, this function checks if the ACPI SPCR table specifies
>its argument of type struct uart_port to be a console
>and if so calls add_preferred_console().
>
>Use SPCR to tell if SBSA serial driver should use 32-bit access to
>registers.

On QDF2432:

Tested-by: Christopher Covington <cov@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

Sent from my Snapdragon powered Android device with K-9 Mail. Please excuse my brevity.
