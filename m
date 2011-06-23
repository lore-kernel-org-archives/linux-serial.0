From: Roland Dreier <roland@kernel.org>
Subject: Re: [PATCH] pch_uart: Add MSI support
Date: Wed, 22 Jun 2011 17:34:27 -0700
Message-ID: <BANLkTim+2Vs7nZqgDnEes5-+CZmuK7_RhA@mail.gmail.com>
References: <1308736219-19975-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308736219-19975-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
List-Id: linux-serial@vger.kernel.org

On Wed, Jun 22, 2011 at 2:50 AM, Alexander Stein
<alexander.stein@systec-electronic.com> wrote:
> + =A0 =A0 =A0 if (priv->use_msi)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_disable_msi(pdev);

Trivial nit: pci_disable_msi() is safe even if you didn't enable msi.
So you can drop the use_msi flag (the PCI layer has dev->msi_enabled
internally to track this), and just always call pci_disable_msi().

 - R.
