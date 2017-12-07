From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH 1/2] acpi, spcr: Make SPCR avialable to other architectures
Date: Thu, 7 Dec 2017 12:43:26 -0600
Message-ID: <CAOZdJXV4E6gu=Ed6nOCcEp2afe_g8Ot-H5oO5=6+ye51cv9hUg@mail.gmail.com>
References: <20171207172912.17868-1-prarit@redhat.com> <20171207172912.17868-2-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20171207172912.17868-2-prarit@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, the arch/x86 maintainers <x86@kernel.org>, linux-pm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, linux-doc@vger.kernel.org, Will Deacon <will.deacon@arm.com>, lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lv Zheng <lv.zheng@intel.com>, linux-serial@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jeffrey Hugo <jhugo@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Dec 7, 2017 at 11:29 AM, Prarit Bhargava <prarit@redhat.com> wrote:
> Other architectures can use SPCR to setup an early console or console but
> the current code is ARM64 specific.
>
> Change the name of parse_spcr() to acpi_parse_spcr().  Add a weak
> function acpi_arch_setup_console() that can be used for arch-specific
> setup.  Move SPCR initialization flag into ACPI code.  Update the
> Documention on the use of the SPCR earlycon.
>
> This patch does not change arm64 behaviour.

Let's hope so.  Our E44 erratum work-around has caused lots of
problems in the past, so the code is a bit fragile.

> +static bool qdf2400_erratum_44_present(struct acpi_table_header *h)
> +{
> +       if (memcmp(h->oem_id, "QCOM  ", ACPI_OEM_ID_SIZE))
> +               return false;
> +
> +       if (!memcmp(h->oem_table_id, "QDF2432 ", ACPI_OEM_TABLE_ID_SIZE))
> +               return true;
> +
> +       if (!memcmp(h->oem_table_id, "QDF2400 ", ACPI_OEM_TABLE_ID_SIZE) &&
> +                       h->oem_revision == 1)
> +               return true;
> +
> +       return false;
> +}

Please give us a chance to test this patch before merging. We've had a
lot of problems with our E44 work-around, and we need to make sure
that qdf2400_erratum_44_present function is called before the pl011
driver is probed.

> +
> +/*
> + * APM X-Gene v1 and v2 UART hardware is an 16550 like device but has its
> + * register aligned to 32-bit. In addition, the BIOS also encoded the
> + * access width to be 8 bits. This function detects this errata condition.
> + */
> +static bool xgene_8250_erratum_present(struct acpi_table_spcr *tb)
> +{
> +       bool xgene_8250 = false;
> +
> +       if (tb->interface_type != ACPI_DBG2_16550_COMPATIBLE)
> +               return false;
> +
> +       if (memcmp(tb->header.oem_id, "APMC0D", ACPI_OEM_ID_SIZE) &&
> +           memcmp(tb->header.oem_id, "HPE   ", ACPI_OEM_ID_SIZE))
> +               return false;
> +
> +       if (!memcmp(tb->header.oem_table_id, "XGENESPC",
> +           ACPI_OEM_TABLE_ID_SIZE) && tb->header.oem_revision == 0)
> +               xgene_8250 = true;
> +
> +       if (!memcmp(tb->header.oem_table_id, "ProLiant",
> +           ACPI_OEM_TABLE_ID_SIZE) && tb->header.oem_revision == 1)
> +               xgene_8250 = true;
> +
> +       return xgene_8250;
> +}

I suspect that this function has the same issues as
qdf2400_erratum_44_present().

> +config ACPI_SPCR_TABLE
> +       bool "ACPI Serial Port Console Redirection Support"
> +       default y if ARM64
> +       help
> +         Enable support for Serial Port Console Redirection (SPCR) Table.
> +         This table provides information about the configuration of the
> +         earlycon console.
> +

So ACPI without SPCR has never been tested by us.  Making it optional
makes me a little nervous.  We'll have to evaluate this change.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
