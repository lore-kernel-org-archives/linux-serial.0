From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH v3 0/5] ACPI: parse the SPCR table
Date: Tue, 16 Feb 2016 14:11:43 -0500
Message-ID: <1455649903.5681.6.camel@redhat.com>
References: <1455559532-8305-1-git-send-email-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455559532-8305-1-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>, linux-acpi@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

On Mon, 2016-02-15 at 21:05 +0300, Aleksey Makarov wrote:
> This patchset is based on the patchset by Leif Lindholm [1]
>=20
> 'ARM Server Base Boot Requirements' [2] mentions SPCR (Serial Port
> Console Redirection Table) [3] as a mandatory ACPI table that
> specifies the configuration of serial console.
>=20
> SPCR support is included in QEMU's ARM mach-virt since 2.4 release.
>=20
> Introduce a new function acpi_console_check().=C2=A0 At the uart port
> registration, this function checks if the ACPI SPCR table specifies
> its argument of type struct uart_port to be a console
> and if so calls add_preferred_console().
>=20
> Use SPCR to tell if SBSA serial driver should use 32-bit access to re=
gisters.
>=20
> To be able to access SPCR table each time any console is registered
> change __init to __ref for early_acpi_os_unmap_memory().
>=20
> The patchset should be applied to tty-next.

On Mustang, m400, and Seattle:

Tested-by: Mark Salter <msalter@redhat.com>
