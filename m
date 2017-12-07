From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH 2/2] acpi, x86: Use SPCR table for earlycon on x86
Date: Thu, 7 Dec 2017 12:46:40 -0600
Message-ID: <CAOZdJXXdeY0+SRfSQC_X-L1UNemigO7DDgRk7jRdMKVe34NWvQ@mail.gmail.com>
References: <20171207172912.17868-1-prarit@redhat.com> <20171207172912.17868-3-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20171207172912.17868-3-prarit@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, the arch/x86 maintainers <x86@kernel.org>, linux-pm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, linux-doc@vger.kernel.org, Will Deacon <will.deacon@arm.com>, lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lv Zheng <lv.zheng@intel.com>, linux-serial@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jeffrey Hugo <jhugo@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Dec 7, 2017 at 11:29 AM, Prarit Bhargava <prarit@redhat.com> wrote:
> -int __init acpi_parse_spcr(bool earlycon)
> +int __init acpi_parse_spcr(bool earlycon, bool enable_console)
>  {
>         static char opts[ACPI_SPCR_OPTS_SIZE];
>         static char uart[ACPI_SPCR_BUF_SIZE];
> @@ -113,7 +113,8 @@ int __init acpi_parse_spcr(bool earlycon)
>         if (earlycon)
>                 setup_earlycon(opts);
>
> -       err = add_preferred_console(uart, 0, opts + strlen(uart) + 1);
> +       if (enable_console)
> +               err = add_preferred_console(uart, 0, opts + strlen(uart) + 1);

So if earlycon==true but enable_console==false, then you parse SPCR
and use it for the early console, but not the primary console?  I'm
not sure what that gives you.
