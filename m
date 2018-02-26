From: John Garry <john.garry@huawei.com>
Subject: Re: [RFC PATCH 0/2] serial: 8250_dw: IO space + polling mode support
Date: Mon, 26 Feb 2018 11:56:15 +0000
Message-ID: <b5904a5a-66d8-4385-cc5b-a52529e9d28f@huawei.com>
References: <1519324923-196857-1-git-send-email-john.garry@huawei.com>
 <1519381801.10722.103.camel@linux.intel.com>
 <3c4c5f58-a661-13c8-cc1c-8d43828982cb@huawei.com>
 <1519407117.10722.124.camel@linux.intel.com>
 <88214a3e-82cc-c931-804c-7dc90fb8721f@huawei.com>
 <1519638828.10722.153.camel@linux.intel.com>
 <7221877b-a84a-63a1-ef86-1991f358df72@huawei.com>
 <1519644517.10722.179.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1519644517.10722.179.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, gregkh@linuxfoundation.org, jslaby@suse.com, p.zabel@pengutronix.de, heiko@sntech.de, ed.blake@sondrel.com, jhogan@kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com
List-Id: linux-serial@vger.kernel.org

>>>>> Why you can't do properly in ACPI?
>>>
>>> No answer here either.
>>>
>>> Sorry, but with this level of communication it's no go for the
>>> series.
>>>
>>
>> Sorry if my answers did not tell you want you want to know.
>>
>> My point was that the 8250_pnp driver would be used for a pnp_device,
>> but we are creating a platform device for this UART slave so would
>> require a platform device driver, that which 8250_dw.c is. But I will
>> check on pnp device support.
>

Hi Andy,

> Perhaps it's not visible, though below is a description of the drivers
> we have:
>
> 8250_dw - OF/ACPI driver for Synopsys DW (+ DW DMA)
> 8250_lpss - PCI driver for Synopsys DW (+ DW DMA)
> 8250_of -  generic 8250 compatible driver for OF
> 8250_pci - generic 8250 compatible driver for PCI
> 8250_pnp - generic 8250 compatible driver for ACPI
>
> 8250_* (except core parts) - custom glue drivers per some IPs
>
> By description you gave your driver fits 8250_pnp if ACPI tables crafted
> properly.
>
> Share the ACPI excerpt and we can discuss further how to improve them.
>

For a bit of background, MFD support was discussed here initially:
https://lkml.org/lkml/2017/6/13/796

Here is the ACPI table:
Scope(_SB) {
   Device (LPC0) {
     Name (_HID, "HISI0191")  // HiSi LPC
     Name (_CRS, ResourceTemplate () {
       Memory32Fixed (ReadWrite, 0xa01b0000, 0x1000)
     })
   }

   Device (LPC0.CON0) {
     Name (_HID, "HISI1031")
     // Name (_CID, "PNP0501") // cannot support PNP
     Name (LORS, ResourceTemplate() {
       QWordIO (
         ResourceConsumer,
     MinNotFixed,     // _MIF
     MaxNotFixed,     // _MAF
     PosDecode,
     EntireRange,
     0x0,             // _GRA
     0x2F8,           // _MIN
     0x3fff,          // _MAX
     0x0,             // _TRA
     0x08,            // _LEN
     , ,
     IO02


The latest framework changes and host driver patchset are here:
https://lkml.org/lkml/2018/2/19/465

Here is how we probe the children:
static int hisi_lpc_acpi_set_io_res(struct device *child,
                     struct device *hostdev,
                     const struct resource **res,
                     int *num_res)
{

     [ ... In this part we just get the child resources ]


     /* translate the I/O resources */
     for (i = 0; i < count; i++) {
         int ret;

         if (!(resources[i].flags & IORESOURCE_IO))
             continue;
         ret = hisi_lpc_acpi_xlat_io_res(adev, host, &resources[i]);
         if (ret) {
             dev_err(child, "translate IO range failed(%d)\n", ret);
             return ret;
         }
     }
     *res = resources;
     *num_res = count;

     return 0;
}

static int hisi_lpc_acpi_probe(struct device *hostdev)
{
     struct acpi_device *adev = ACPI_COMPANION(hostdev);
     struct hisi_lpc_mfd_cell *hisi_lpc_mfd_cells;
     struct mfd_cell *mfd_cells;
     struct acpi_device *child;
     int size, ret, count = 0, cell_num = 0;

     list_for_each_entry(child, &adev->children, node)
         cell_num++;

     /* allocate the mfd cell and companion acpi info, one per child */
     size = sizeof(*mfd_cells) + sizeof(*hisi_lpc_mfd_cells);
     mfd_cells = devm_kcalloc(hostdev, cell_num, size, GFP_KERNEL);
     if (!mfd_cells)
         return -ENOMEM;

     hisi_lpc_mfd_cells = (struct hisi_lpc_mfd_cell *)
                     &mfd_cells[cell_num];
     /* Only consider the children of the host */
     list_for_each_entry(child, &adev->children, node) {
         struct mfd_cell *mfd_cell = &mfd_cells[count];
         struct hisi_lpc_mfd_cell *hisi_lpc_mfd_cell =
                     &hisi_lpc_mfd_cells[count];
         struct mfd_cell_acpi_match *acpi_match =
                     &hisi_lpc_mfd_cell->acpi_match;
         char *name = hisi_lpc_mfd_cell[count].name;
         char *pnpid = hisi_lpc_mfd_cell[count].pnpid;
         struct mfd_cell_acpi_match match = {
             .pnpid = pnpid,
         };

         snprintf(name, MFD_CHILD_NAME_LEN, MFD_CHILD_NAME_PREFIX"%s",
              acpi_device_hid(child));
         snprintf(pnpid, ACPI_ID_LEN, "%s", acpi_device_hid(child));

         memcpy(acpi_match, &match, sizeof(*acpi_match));
         mfd_cell->name = name;
         mfd_cell->acpi_match = acpi_match;

         ret = hisi_lpc_acpi_set_io_res(&child->dev, &adev->dev,
                            &mfd_cell->resources,
                            &mfd_cell->num_resources);
         if (ret) {
             dev_warn(&child->dev, "set resource fail(%d)\n", ret);
             return ret;
         }
         count++;
     }

     ret = mfd_add_devices(hostdev, PLATFORM_DEVID_NONE,
                   mfd_cells, cell_num, NULL, 0, NULL);
     if (ret) {
         dev_err(hostdev, "failed to add mfd cells (%d)\n", ret);
         return ret;
     }

     return 0;
}

As you know, this is not accepted upstream yet, but I really hope I'm 
close. Hence the RFC tag for the UART patchset.

Please let me know if you require more details.

Thanks,
John
