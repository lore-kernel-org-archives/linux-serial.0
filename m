From: Mike Galbraith <mgalbraith@suse.de>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference at
 00000000000001e0
Date: Tue, 25 Oct 2016 03:47:12 +0200
Message-ID: <1477360032.3798.6.camel@suse.de>
References: <20161024144831.a4ieul22jck4vwk3@pd.tnic>
         <49489eb2-c7f5-369b-4552-d888cbc27719@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <49489eb2-c7f5-369b-4552-d888cbc27719@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>, Borislav Petkov <bp@alien8.de>, linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, 2016-10-24 at 17:28 +0200, Jiri Slaby wrote:
On 10/24/2016, 04:48 PM, Borislav Petkov wrote:
> Hi people,
> 
> typing "reboot" splats the following on the serial console. Ideas?
> 
> INIT: Sending p[  427.863916] BUG: unable to handle kernel NULL pointer dereference at 00000000000001e0
> [  427.885156] IP: [] tty_wakeup+0xc/0x70
> [  427.898337] PGD 0 [  427.902051] 
> [  427.907498] Oops: 0000 [#1] PREEMPT SMP
> [  427.917635] Modules linked in: nfsv3 nfs_acl nfs fscache lockd sunrpc grace edd af_packet cpufreq_conservative cpufreq_userspace cpufreq_powersave fuse loop md_mod dm_mod joydev hid_generic usbhid ipmi_ssif ohci_pci ohci_hcd ehci_pci ehci_hcd e1000e ptp firewire_ohci edac_core pps_core tpm_infineon sp5100_tco firewire_core acpi_cpufreq serio_raw pcspkr fjes usbcore shpchp edac_mce_amd tpm_tis ipmi_si tpm_tis_core i2c_piix4 k10temp sg ipmi_msghandler tpm sr_mod button cdrom kvm_amd kvm irqbypass crc_itu_t ast ttm drm_kms_helper drm fb_sys_fops sysimgblt sysfillrect syscopyarea i2c_algo_bit scsi_dh_rdac scsi_dh_alua scsi_dh_emc scsi_dh_hp_sw ata_generic pata_atiixp
> [  428.054179] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.9.0-rc1-1.g73e3f23-default #1
> [  428.072868] Hardware name: System manufacturer System Product Name/KGP(M)E-D16, BIOS 0902    12/03/2010
> [  428.094755] task: ffffffffa2c0d500 task.stack: ffffffffa2c00000
> [  428.109717] RIP: 0010:[]  [] tty_wakeup+0xc/0x70
> [  428.128407] RSP: 0018:ffff9a1a5fc03df8  EFLAGS: 00010086
> [  428.142184] RAX: ffff9a1857258000 RBX: ffffffffa3050ea0 RCX: 0000000000000000
> [  428.159649] RDX: 000000000000001b RSI: 0000000000000000 RDI: 0000000000000000
> [  428.177109] RBP: ffff9a1a5fc03e08 R08: 0000000000000000 R09: 0000000000000000
> [  428.194547] R10: 0000000000021c77 R11: 0000000000000000 R12: ffff9a1857258000
> [  428.212002] R13: 0000000000000000 R14: 0000000000000020 R15: 0000000000000020
> [  428.229481] FS:  0000000000000000(0000) GS:ffff9a1a5fc00000(0000) knlGS:0000000000000000
> [  428.248938] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  428.263726] CR2: 00000000000001e0 CR3: 0000000390c06000 CR4: 00000000000006f0
> [  428.281331] Stack:
> [  428.288696]  ffffffffa3050ea0 ffff9a1857258000 ffff9a1a5fc03e18 ffffffffa24e0ab1
> [  428.307064]  ffff9a1a5fc03e40 ffffffffa24e8865 ffffffffa3050ea0 00000000000000c2
> [  428.325456]  0000000000000046 ffff9a1a5fc03e78 ffffffffa24e8a5f ffffffffa3050ea0
> [  428.343905] Call Trace:
> [  428.352319]   [  428.356216]  [] uart_write_wakeup+0x21/0x30
> Does this help (compile-tested only)?
> 
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -106,12 +106,17 @@ static inline struct uart_port
> *uart_port_check(struct uart_state *state)
>  void uart_write_wakeup(struct uart_port *port)
>  {
>         struct uart_state *state = port->state;
> +       struct tty_struct *ttyp;
>         /*
>          * This means you called this function _after_ the port was
>          * closed.  No cookie for you.
>          */
>         BUG_ON(!state);
> -       tty_wakeup(state->port.tty);
> +
> +       ttyp = tty_port_tty_get(&state->port);
> +       if (ttyp)
> +               tty_wakeup(ttyp);
> +       tty_kref_put(ttyp);
>  }
> 
>  static void uart_stop(struct tty_struct *tty)

Well, I now see that Boris has already tested it, but since I just did
that too, I'll add a CC to make my 'yup, all better' less redundant :)

	-Mike
